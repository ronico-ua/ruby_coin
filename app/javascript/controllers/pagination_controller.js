import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.addAnchorsToPaginationLinks();
  }

  addAnchorsToPaginationLinks() {
    const paginationLinks = this.element.querySelectorAll('.pagination__inner a');
    const anchor = 'posts-list';

    paginationLinks.forEach(link => {
      const url = new URL(link.href);
      url.hash = anchor;
      link.href = url.toString();
    });
  }
}