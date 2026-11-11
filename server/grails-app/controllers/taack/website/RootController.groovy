package taack.website

import crew.config.SupportedLanguage
import crew.User
import plm.PlmFreeCadPart
import plm.PlmPartLifecycleState
import workspace.PlmWorkspace
import workspace.PlmWorkspaceMember
import changemanagement.DesignChangeNotice
import changemanagement.DcnPart
import serveradmin.ServerJob
import serveradmin.ServerEvent
import grails.compiler.GrailsCompileStatic
import grails.plugin.springsecurity.annotation.Secured
import org.codehaus.groovy.runtime.MethodClosure as MC
import taack.app.TaackApp
import taack.app.TaackAppRegisterService
import taack.render.TaackUiService
import taack.ui.dsl.UiBlockSpecifier
import taack.ui.dsl.UiMenuSpecifier
import taack.ui.dsl.UiShowSpecifier
import taack.ui.dsl.block.BlockSpec
import taack.ui.dump.Parameter

/*
TODO: Add an infrastructure to list new stuffs from a user and a timestamp
 */

@Secured(['isAuthenticated()'])
class RootController {
    TaackUiService taackUiService
    RootSearchService rootSearchService

    private static UiMenuSpecifier buildMenu(String q = null) {
        UiMenuSpecifier m = new UiMenuSpecifier()
        m.ui {
            menu this.&index as MC
            menuSearch RootController.&search as MC, q
            menuOptions(SupportedLanguage.fromContext())
        }
        m
    }

    def springSecurityService

    /**
     * Personal home page. All collections are scoped to the authenticated user.
     * DCN participation is derived from DCN_CREATE audit events and part links;
     * the current DCN domain has no owner/assignee field.
     */
    def index() {
        User current = springSecurityService.currentUser as User
        String username = current?.username
        boolean plmAccess = request.isUserInRole('ROLE_PLM_USER') ||
                            request.isUserInRole('ROLE_ADMIN')
        if (!current || !plmAccess) {
            return [plmAccess: false, dcns: [], parts: [], workspaces: [], jobs: []]
        }

        List<PlmFreeCadPart> parts = PlmFreeCadPart.findAllByCheckedOutBy(
                current, [sort: 'checkedOutAt', order: 'desc', max: 200]).findAll {
            it.active == true && it.nextVersion == null &&
                    it.lifecycleState == PlmPartLifecycleState.CHECKED_OUT
        }

        List<PlmWorkspace> owned = PlmWorkspace.findAllByOwner(current)
        List<PlmWorkspaceMember> memberships = PlmWorkspaceMember.findAllByUser(current)
        List<PlmWorkspace> workspaces = (owned + memberships.collect { it.workspace })
                .findAll { it != null }.unique { it.id }
                .sort { it.name?.toLowerCase() ?: '' }

        List<ServerJob> jobs = username ?
                ServerJob.findAllBySubmittedBy(username,
                        [sort: 'dateCreated', order: 'desc', max: 100]) : []

        // Existing audit events record the creator's username, while the
        // DCN itself does not currently contain a user ownership field.
        Set<Long> dcnIds = [] as Set<Long>
        if (username) {
            ServerEvent.findAllByEventTypeAndActor('DCN_CREATE', username,
                    [sort: 'dateCreated', order: 'desc', max: 1000]).each { event ->
                if (event.entityType == 'DesignChangeNotice' &&
                        event.entityId?.isLong()) {
                    dcnIds.add(event.entityId.toLong())
                }
            }
        }
        // A checked-out part associated with a DCN also establishes involvement.
        parts.each { part ->
            if (part.dcn) {
                def linkedDcn = DesignChangeNotice.findByDcnNumber(part.dcn)
                if (linkedDcn) dcnIds.add(linkedDcn.id)
            }
            DcnPart.findAllByPart(part).each { link ->
                if (link.dcn?.id) dcnIds.add(link.dcn.id)
            }
        }
        List<DesignChangeNotice> dcns = dcnIds ?
                DesignChangeNotice.findAllByIdInList(dcnIds.toList(),
                        [sort: 'lastUpdated', order: 'desc', max: 200]).findAll {
                    it.status != 'RELEASED' && it.status != 'CANCELLED'
                } : []

        [plmAccess: true, currentUserId: current.id, dcns: dcns, parts: parts,
         workspaces: workspaces, jobs: jobs]
    }

    def search(String q) {
        taackUiService.show(rootSearchService.buildSearchBlock(q), buildMenu(q))
    }

    def updates() {
        taackUiService.show(new UiBlockSpecifier().ui {
            ajaxBlock 'updates', {
                show(new UiShowSpecifier().ui {
                    inlineHtml('WiP', '')
                })
            }
        }, buildMenu())
    }

    def todo() {
        taackUiService.show(new UiBlockSpecifier().ui {
            ajaxBlock 'todo', {
                show(new UiShowSpecifier().ui {
                    inlineHtml('WiP', '')
                })
            }
        }, buildMenu())
    }

    @Secured(['ROLE_ADMIN'])
    def solrIndexAll() {
        rootSearchService.taackSearchService.indexAll()
        render 'Done !'
    }
}
