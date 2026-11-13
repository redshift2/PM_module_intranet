<!doctype html>
<html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Sign in — Parts Manager</title>
<style>
:root{color-scheme:dark;font-family:system-ui,-apple-system,"Segoe UI",sans-serif}*{box-sizing:border-box}
body{margin:0;min-height:100vh;background:#1e2328;color:#f0f5fb;display:flex;flex-direction:column}
header{height:66px;background:#1c65a5;border-top:5px solid #0b2b4a;display:flex;align-items:center;padding:0 30px;font-size:19px;font-weight:650;letter-spacing:.2px}
main{flex:1;display:flex;justify-content:center;align-items:center;padding:28px 16px}
.card{width:100%;max-width:420px;background:#282f36;border:1px solid #435363;border-radius:10px;overflow:hidden;box-shadow:0 18px 48px #0005}
.card h1{margin:0;background:#0c2c4d;font-size:21px;padding:20px 25px}
.inner{padding:25px}.intro{color:#c3d0de;margin:0 0 24px;font-size:14px}
label{display:block;font-size:14px;font-weight:600;margin:0 0 8px}input[type=text],input[type=password]{display:block;width:100%;background:#1b2229;border:1px solid #667889;border-radius:6px;padding:12px;color:#fff;font:inherit;margin-bottom:19px}
input:focus{outline:2px solid #80c4ff;outline-offset:1px}.remember{display:flex;align-items:center;gap:9px;margin:0 0 22px;font-weight:400;color:#d8e3ee}
button{background:#176fb7;color:#fff;font:inherit;font-weight:650;border:0;border-radius:6px;padding:12px;width:100%;cursor:pointer}button:hover{background:#2384d1}
.alert{padding:12px 14px;border-radius:6px;margin-bottom:18px;font-size:14px}.error{background:#512b31;color:#ffdde0;border:1px solid #a94d58}.info{background:#1c4148;color:#d2f4f7;border:1px solid #36828b}
footer{text-align:center;padding:18px;color:#a8b8c8;font-size:12px}
@media(prefers-color-scheme:light){:root{color-scheme:light}body{background:#edf2f7;color:#182b3c}.card{background:white;border-color:#cbd6e2;box-shadow:0 12px 32px #1232}.intro{color:#4c6074}input[type=text],input[type=password]{background:#fff;color:#162738;border-color:#899db0}.remember{color:#314b63}.error{background:#ffedef;color:#84212f}.info{background:#e3f8f8;color:#17535c}footer{color:#5d6d7d}}
</style></head><body>
<header>Parts Manager</header>
<main><section class="card" aria-labelledby="login-title"><h1 id="login-title">Sign in</h1><div class="inner">
<p class="intro">Sign in to access your Parts Manager workspace.</p>
<g:if test="${params.login_error || params.error}"><div class="alert error" role="alert">Sign-in failed. Please try again.</div></g:if>
<g:if test="${flash.error}"><div class="alert error">${flash.error?.encodeAsHTML()}</div></g:if>
<g:if test="${params.logout}"><div class="alert info" role="status">You have been signed out.</div></g:if>
<form action="${postUrl?.encodeAsHTML()}" method="post" autocomplete="on">
<label for="username">Username</label><input id="username" name="username" type="text" autocomplete="username" required autofocus>
<label for="password">Password</label><input id="password" name="password" type="password" autocomplete="current-password" required>
<label class="remember"><input type="checkbox" name="rememberMe" value="on"> Remember me</label>
<button type="submit">Sign in</button>
</form><g:if test="${oidcProviders}"><hr style="margin:24px 0;border:0;border-top:1px solid #526171"/><p class="intro">Or sign in with an external provider</p><g:each in="${oidcProviders}" var="p"><p><a style="display:block;text-align:center;background:#176fb7;color:white;padding:12px;border-radius:6px;text-decoration:none" href="${request.contextPath}/oidcLogin/start?id=${p.id}">Sign in with ${p.name?.encodeAsHTML()}</a></p></g:each></g:if><p style="margin-top:18px;font-size:13px"><a style="color:#83c5ff" href="${request.contextPath}/oidcLogin/account">Account Connections</a> (sign in locally first to link)</p></div></section></main><footer>Parts Manager · Secure access</footer>
</body></html>
