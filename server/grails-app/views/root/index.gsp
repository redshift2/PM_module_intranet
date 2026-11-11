<div class="pm-shell" data-pm-theme="dark">
<g:render template="/shared/pmShellStyles"/>
<g:render template="/shared/pmShellSidebar"/>
<div class="pm-main">
<g:render template="/shared/pmShellHeader" model="[moduleTitle:'Home']"/>
<main class="pm-content">
<style>
.pm-dashboard{max-width:1600px;margin:auto;color:var(--pm-text)}
.pm-dashboard .pm-welcome{margin:0 0 20px}.pm-dashboard h1{font-size:25px;margin:0 0 5px}.pm-dashboard .pm-sub{color:var(--pm-muted);margin:0}
.pm-dashboard .pm-grid{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:18px}
.pm-dashboard .pm-card{background:var(--pm-surface);border:1px solid var(--pm-border);border-radius:8px;min-width:0;overflow:hidden}
.pm-dashboard .pm-card-head{background:var(--pm-sidebar);padding:15px 17px;display:flex;align-items:center;justify-content:space-between;gap:12px}
.pm-dashboard .pm-card-head h2{margin:0;font-size:17px;font-weight:650}.pm-dashboard .pm-count{display:inline-block;background:var(--pm-blue);color:#fff;padding:3px 10px;border-radius:15px;font-size:13px}
.pm-dashboard .pm-card-head a,.pm-dashboard .pm-link{color:#8ac8ff;text-decoration:none}.pm-shell[data-pm-theme=light] .pm-dashboard .pm-card-head a,.pm-shell[data-pm-theme=light] .pm-dashboard .pm-link{color:#155b9c}
.pm-dashboard .pm-tablewrap{overflow-x:auto}.pm-dashboard table{width:100%;border-collapse:collapse;font-size:13px}.pm-dashboard th,.pm-dashboard td{text-align:left;padding:11px 13px;border-bottom:1px solid var(--pm-border);vertical-align:middle}.pm-dashboard th{font-weight:600;color:var(--pm-muted);white-space:nowrap}.pm-dashboard td{overflow-wrap:anywhere}.pm-dashboard .pm-empty{padding:22px;color:var(--pm-muted)}.pm-dashboard .pm-badge{font-size:12px;border:1px solid var(--pm-border);border-radius:5px;padding:3px 7px;white-space:nowrap}.pm-dashboard .pm-note{margin:14px 0;color:var(--pm-muted);font-size:12px}

/* Dashboard-specific contrast: shared shell theme variables may not define
   --pm-text / --pm-surface for table content. */
.pm-shell[data-pm-theme="dark"] .pm-dashboard {color:#f1f5f9}
.pm-shell[data-pm-theme="dark"] .pm-dashboard .pm-card {background:#252b31;border-color:#44515d}
.pm-shell[data-pm-theme="dark"] .pm-dashboard .pm-card-head {background:#0b2b4a;color:#f5f9ff}
.pm-shell[data-pm-theme="dark"] .pm-dashboard td {color:#edf2f7;border-bottom-color:#44515d}
.pm-shell[data-pm-theme="dark"] .pm-dashboard th {color:#c8d6e5;border-bottom-color:#44515d}
.pm-shell[data-pm-theme="dark"] .pm-dashboard .pm-sub,
.pm-shell[data-pm-theme="dark"] .pm-dashboard .pm-note,
.pm-shell[data-pm-theme="dark"] .pm-dashboard .pm-empty {color:#cbd5e1}
.pm-shell[data-pm-theme="dark"] .pm-dashboard .pm-badge {color:#e5edf6;border-color:#64748b;background:#334155}
.pm-shell[data-pm-theme="dark"] .pm-dashboard .pm-link {color:#8bd1ff;text-decoration:underline;text-underline-offset:2px}
.pm-shell[data-pm-theme="dark"] .pm-dashboard .pm-link:hover {color:#c3e8ff}
.pm-shell[data-pm-theme="light"] .pm-dashboard {color:#182534}
.pm-shell[data-pm-theme="light"] .pm-dashboard .pm-card {background:#fff;border-color:#d6dee8}
.pm-shell[data-pm-theme="light"] .pm-dashboard .pm-card-head {background:#e8f2fc;color:#123d63}
.pm-shell[data-pm-theme="light"] .pm-dashboard td {color:#243343;border-bottom-color:#dbe3eb}
.pm-shell[data-pm-theme="light"] .pm-dashboard th,
.pm-shell[data-pm-theme="light"] .pm-dashboard .pm-sub,
.pm-shell[data-pm-theme="light"] .pm-dashboard .pm-note,
.pm-shell[data-pm-theme="light"] .pm-dashboard .pm-empty {color:#506276}
.pm-shell[data-pm-theme="light"] .pm-dashboard .pm-badge {color:#253b53;border-color:#b8c9d9;background:#f2f6fa}

@media(max-width:1050px){.pm-dashboard .pm-grid{grid-template-columns:1fr}}
</style>
<div class="pm-dashboard">
<div class="pm-welcome"><h1>My Workspace</h1><p class="pm-sub">Your active changes, parts, workspaces and processing jobs.</p></div>
<g:if test="${!plmAccess}"><div class="pm-card"><div class="pm-empty">Your account does not have PLM access. Contact an administrator if you need access to these modules.</div></div></g:if>
<g:else>
<div class="pm-grid">
<section class="pm-card"><div class="pm-card-head"><h2>My Non-Released DCNs <span class="pm-count">${dcns.size()}</span></h2><g:link controller="changeManagement" action="index">View all DCNs →</g:link></div><div class="pm-tablewrap"><table><thead><tr><th>DCN</th><th>Title</th><th>Status</th><th>Updated</th></tr></thead><tbody><g:each in="${dcns}" var="d"><tr><td><g:link class="pm-link" controller="changeManagement" action="dcn" id="${d.id}">${d.dcnNumber?.encodeAsHTML()}</g:link></td><td>${d.title?.encodeAsHTML()}</td><td><span class="pm-badge">${d.status?.encodeAsHTML()}</span></td><td><g:formatDate date="${d.lastUpdated}" format="yyyy-MM-dd"/></td></tr></g:each></tbody></table><g:if test="${!dcns}"><div class="pm-empty">No active DCNs linked to your activity.</div></g:if></div></section>
<section class="pm-card"><div class="pm-card-head"><h2>My Checked-Out Parts <span class="pm-count">${parts.size()}</span></h2></div><div class="pm-tablewrap"><table><thead><tr><th>Part</th><th>CAD Version</th><th>Checked Out</th></tr></thead><tbody><g:each in="${parts}" var="part"><tr><td><g:link class="pm-link" controller="plm" action="showPart" id="${part.id}">${(part.label ?: part.originalName ?: ('Part #' + part.id))?.encodeAsHTML()}</g:link></td><td>${part.majorVersion ?: 1}.${part.minorVersion ?: 0}</td><td><g:formatDate date="${part.checkedOutAt}" format="yyyy-MM-dd HH:mm"/></td></tr></g:each></tbody></table><g:if test="${!parts}"><div class="pm-empty">You have no checked-out parts.</div></g:if></div></section>
<section class="pm-card"><div class="pm-card-head"><h2>My Workspaces <span class="pm-count">${workspaces.size()}</span></h2><g:link controller="workspace" action="index">Manage Workspaces →</g:link></div><div class="pm-tablewrap"><table><thead><tr><th>Workspace</th><th>Description</th><th>Access</th></tr></thead><tbody><g:each in="${workspaces}" var="w"><tr><td><g:link class="pm-link" controller="workspace" action="show" id="${w.id}">${w.name?.encodeAsHTML()}</g:link></td><td>${w.description?.encodeAsHTML()}</td><td><span class="pm-badge">${w.owner?.id == currentUserId ? 'Owner' : 'Member'}</span></td></tr></g:each></tbody></table><g:if test="${!workspaces}"><div class="pm-empty">No workspaces available to your account.</div></g:if></div></section>
<section class="pm-card"><div class="pm-card-head"><h2>My Job Queue <span class="pm-count">${jobs.size()}</span></h2><g:link controller="serverAdmin" action="jobQueue">View Job Queue →</g:link></div><div class="pm-tablewrap"><table><thead><tr><th>Job</th><th>Type</th><th>Status</th><th>Progress</th><th>Submitted</th></tr></thead><tbody><g:each in="${jobs}" var="job"><tr><td>#${job.id}</td><td>${job.jobType?.encodeAsHTML()}</td><td><span class="pm-badge">${job.status?.encodeAsHTML()}</span></td><td>${job.progressPercent ?: 0}%</td><td><g:formatDate date="${job.dateCreated}" format="yyyy-MM-dd HH:mm"/></td></tr></g:each></tbody></table><g:if test="${!jobs}"><div class="pm-empty">No jobs submitted by your account.</div></g:if></div></section>
</div><p class="pm-note">DCNs are matched using creation audit records and associations with your checked-out parts. Job history shows jobs submitted by your account. Counts reflect the most recent records shown.</p>
</g:else>
</div></main></div><g:render template="/shared/pmShellScript"/></div>
