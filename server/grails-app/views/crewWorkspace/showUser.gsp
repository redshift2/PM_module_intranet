<div class="pm-shell" data-pm-theme="dark">
<g:render template="/shared/pmShellStyles"/>
<g:render template="/shared/pmShellSidebar"/>
<div class="pm-main"><g:render template="/shared/pmShellHeader" model="[moduleTitle:'User Management']"/>
<main class="pm-content"><style>
.pm-shell .crew-wrap{padding:18px 12px 32px;color:var(--pm-text)}
.pm-shell .crew-tabs{display:flex;gap:8px;margin-bottom:18px;flex-wrap:wrap}
.pm-shell .crew-btn,.pm-shell .crew-tabs a{display:inline-block;padding:9px 13px;background:var(--pm-surface);color:var(--pm-text);border:1px solid var(--pm-border);border-radius:5px;text-decoration:none}
.pm-shell .crew-tabs a.active{background:var(--pm-blue);color:#fff}
.pm-shell .crew-card{border:1px solid var(--pm-border);background:var(--pm-surface);border-radius:6px;overflow:hidden}
.pm-shell .crew-card h2{padding:15px;margin:0;background:var(--pm-sidebar);font-size:17px}
.pm-shell .crew-table-wrap{overflow-x:auto}
.pm-shell .crew-table{width:100%;border-collapse:collapse}
.pm-shell .crew-table th,.pm-shell .crew-table td{text-align:left;padding:11px 13px;border-bottom:1px solid var(--pm-border);color:var(--pm-text)}
.pm-shell .crew-table th{background:var(--pm-sidebar)}
.pm-shell .crew-table tbody tr:nth-child(even){background:color-mix(in srgb,var(--pm-surface) 70%,var(--pm-sidebar))}
.pm-shell .crew-form{display:flex;gap:9px;padding:14px;align-items:center;flex-wrap:wrap}
.pm-shell .crew-form input{min-width:230px;flex:1;background:var(--pm-bg);border:1px solid var(--pm-border);border-radius:4px;padding:9px;color:var(--pm-text)}
.pm-shell .crew-link{color:#8bc6ff}
.pm-shell[data-pm-theme=light] .crew-link{color:#155a99}
.pm-shell .crew-foot{display:flex;gap:12px;align-items:center;padding:12px}
</style>
<div class="crew-wrap"><nav class="crew-tabs"><a href="${request.contextPath}/crewWorkspace/index">Users</a><a href="${request.contextPath}/crewWorkspace/roles">Roles</a><a href="${request.contextPath}/crewWorkspace/hierarchy">Organization Hierarchy</a></nav>
<section class="crew-card"><h2>User Details</h2><div class="crew-table-wrap"><table class="crew-table"><tbody>
<tr><th>Username</th><td>${user.username?.encodeAsHTML()}</td></tr>
<tr><th>Name</th><td>${((user.firstName ?: '') + ' ' + (user.lastName ?: '')).trim().encodeAsHTML()}</td></tr>
<tr><th>Email</th><td>${user.mail?.encodeAsHTML()}</td></tr>
<tr><th>Manager</th><td>${user.manager?.username?.encodeAsHTML()}</td></tr>
<tr><th>Business Unit</th><td>${user.businessUnit?.toString()?.encodeAsHTML()}</td></tr>
<tr><th>Subsidiary</th><td>${user.subsidiary?.toString()?.encodeAsHTML()}</td></tr>
<tr><th>Enabled</th><td>${user.enabled ? 'Yes' : 'No'}</td></tr>
<tr><th>Account Locked</th><td>${user.accountLocked ? 'Yes' : 'No'}</td></tr>
<tr><th>Account Expired</th><td>${user.accountExpired ? 'Yes' : 'No'}</td></tr>
<tr><th>Password Expired</th><td>${user.passwordExpired ? 'Yes' : 'No'}</td></tr>
<tr><th>Roles</th><td><g:each in="${assignedRoles}" var="role">${role.authority?.encodeAsHTML()} &nbsp;</g:each></td></tr>
</tbody></table></div><div class="crew-foot"><a class="crew-btn" href="${request.contextPath}/crewWorkspace/index">Back to Users</a><sec:ifAllGranted roles="ROLE_ADMIN"><a class="crew-btn" href="${request.contextPath}/crewWorkspace/editUser/${user.id}">Edit User</a><a class="crew-btn" href="${request.contextPath}/crewWorkspace/userRoles/${user.id}">Manage Roles</a></sec:ifAllGranted></div></section></div></main></div><g:render template="/shared/pmShellScript"/></div>
