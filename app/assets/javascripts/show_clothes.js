document.addEventListener('DOMContentLoaded', function () {
  document.getElementById('select-all').addEventListener('click', function () {
    document.querySelectorAll('input[type="checkbox"][name="types[]"]').forEach(function (checkbox) {
      checkbox.checked = true;
    });
  });

  document.getElementById('deselect-all').addEventListener('click', function () {
    document.querySelectorAll('input[type="checkbox"][name="types[]"]').forEach(function (checkbox) {
      checkbox.checked = false;
    });
  });
});