<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <title><g:layoutTitle default="Parts Manager"/></title>
  <asset:stylesheet src="parts-manager-shell.css"/>
  <g:layoutHead/>
</head>
<body class="pm-shell" data-pm-theme="dark">
  <aside class="pm-sidebar" id="pm-sidebar" aria-label="Module navigation">
    <button class="pm-toggle" id="pm-toggle" type="button" aria-expanded="false" aria-controls="pm-sidebar" title="Expand navigation">☰ <span class="pm-label">Parts Manager</span></button>
    <nav class="pm-nav" aria-label="Modules">
      <div class="pm-entry"><a class="pm-module" href="${g.createLink(uri:'/')}" aria-label="Home"><span class="pm-icon">⌂</span><span class="pm-label">Home</span></a></div>
      <div class="pm-entry" data-pm-module="plm"><a class="pm-module" href="${g.createLink(controller:'plm',action:'parts')}" aria-label="PLM"><span class="pm-icon">▣</span><span class="pm-label">PLM</span></a><div class="pm-flyout"><strong>PLM</strong><a href="${g.createLink(controller:'plm',action:'parts')}">Parts</a></div></div>
      <div class="pm-entry" data-pm-module="materials"><a class="pm-module" href="${g.createLink(controller:'material',action:'index')}" aria-label="Materials"><span class="pm-icon">⬡</span><span class="pm-label">Materials</span></a><div class="pm-flyout"><strong>Materials</strong><a href="${g.createLink(controller:'material',action:'index')}">Materials Library</a></div></div>
      <div class="pm-entry" data-pm-module="changeManagement"><a class="pm-module" href="${g.createLink(controller:'changeManagement',action:'index')}" aria-label="Change Management"><span class="pm-icon">⇄</span><span class="pm-label">Change Management</span></a><div class="pm-flyout"><strong>Change Management</strong><a href="${g.createLink(controller:'changeManagement',action:'index',params:[tab:'dcn'])}">DCNs</a><a href="${g.createLink(controller:'changeManagement',action:'index',params:[tab:'projects'])}">Projects</a></div></div>
      <div class="pm-entry" data-pm-module="serverAdmin"><a class="pm-module" href="${g.createLink(controller:'serverAdmin',action:'index')}" aria-label="Server Administration"><span class="pm-icon">⚙</span><span class="pm-label">Server Administration</span></a><div class="pm-flyout"><strong>Server Administration</strong><a href="${g.createLink(controller:'serverAdmin',action:'index')}">Dashboard</a></div></div>
    </nav>
  </aside>
  <div class="pm-main">
    <header class="pm-header">
      <div class="pm-title"><g:layoutTitle default="Parts Manager"/></div>
      <div class="pm-account">
        <span class="pm-user"><sec:username/></span>
        <a class="pm-header-action" href="${g.createLink(uri:'/')}" title="Settings" aria-label="Settings">⚙</a>
        <button class="pm-header-action" id="pm-theme" type="button" title="Toggle light/dark theme" aria-label="Toggle light/dark theme">☀</button>
        <g:form controller="logout" method="POST" class="pm-logout"><button class="pm-header-action" type="submit" title="Log out" aria-label="Log out">⏻</button></g:form>
      </div>
    </header>
    <main class="pm-content"><g:layoutBody/></main>
  </div>
  <asset:javascript src="parts-manager-shell.js"/>
</body>
</html>
