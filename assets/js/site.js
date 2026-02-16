(function () {
  var navToggle = document.querySelector('[data-nav-toggle]');
  var nav = document.querySelector('[data-nav]');

  if (navToggle && nav) {
    navToggle.addEventListener('click', function () {
      var isOpen = nav.classList.toggle('open');
      navToggle.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
    });
  }

  var filterButtons = document.querySelectorAll('[data-filter]');
  var articleCards = document.querySelectorAll('[data-tags]');

  if (filterButtons.length && articleCards.length) {
    filterButtons.forEach(function (btn) {
      btn.addEventListener('click', function () {
        var filter = btn.getAttribute('data-filter');

        filterButtons.forEach(function (b) {
          b.setAttribute('aria-pressed', b === btn ? 'true' : 'false');
        });

        articleCards.forEach(function (card) {
          var tags = card.getAttribute('data-tags') || '';
          var show = filter === 'all' || tags.indexOf(filter) !== -1;
          card.classList.toggle('hidden', !show);
        });
      });
    });
  }
})();
