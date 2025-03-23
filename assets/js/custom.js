// Custom JS for interactivity
document.addEventListener("DOMContentLoaded", function () {
    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach((anchor) => {
      anchor.addEventListener("click", function (e) {
        e.preventDefault();
        document.querySelector(this.getAttribute("href")).scrollIntoView({
          behavior: "smooth",
        });
      });
    });
  
    // Dynamic year in footer
    const year = new Date().getFullYear();
    document.querySelector("footer .copyright").textContent = `© Rishabh Nair ${year}`;
  });