(function () {
  'use strict';
  var body=document.body, toggle=document.getElementById('pm-toggle'), theme=document.getElementById('pm-theme');
  function setExpanded(value) { body.classList.toggle('pm-expanded',value); toggle.setAttribute('aria-expanded',String(value)); try { localStorage.setItem('pm-sidebar-expanded',String(value)); } catch(e) {} }
  try { setExpanded(localStorage.getItem('pm-sidebar-expanded')==='true'); } catch(e) { setExpanded(false); }
  toggle.addEventListener('click',function(){ setExpanded(!body.classList.contains('pm-expanded')); });
  function setTheme(value) { body.setAttribute('data-pm-theme',value); theme.textContent=value==='dark'?'☀':'☾'; try { localStorage.setItem('pm-theme',value); } catch(e) {} }
  try { setTheme(localStorage.getItem('pm-theme')==='light'?'light':'dark'); } catch(e) { setTheme('dark'); }
  theme.addEventListener('click',function(){ setTheme(body.getAttribute('data-pm-theme')==='dark'?'light':'dark'); });
  var current=(location.pathname.split('/')[1]||'').toLowerCase();
  document.querySelectorAll('[data-pm-module]').forEach(function(entry) {
    if (entry.dataset.pmModule.toLowerCase()===current) entry.classList.add('pm-active');
    var link=entry.querySelector('.pm-module');
    link.addEventListener('click',function(ev) {
      if (window.matchMedia('(hover:none)').matches && !entry.classList.contains('pm-open')) {
        ev.preventDefault(); document.querySelectorAll('.pm-entry.pm-open').forEach(function(e){e.classList.remove('pm-open');}); entry.classList.add('pm-open');
      }
    });
  });
  document.addEventListener('keydown',function(ev){if(ev.key==='Escape') document.querySelectorAll('.pm-entry.pm-open').forEach(function(e){e.classList.remove('pm-open');});});
  document.addEventListener('click',function(ev){if(!ev.target.closest('.pm-entry')) document.querySelectorAll('.pm-entry.pm-open').forEach(function(e){e.classList.remove('pm-open');});});
})();
