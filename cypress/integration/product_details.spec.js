describe("Product Details", () => {
  beforeEach(() => {
    cy.visit("http://localhost:3000");
  });

  it("navigates directly to a product detail page when the product is clicked", () => {
    cy.get(".products article").should("be.visible").eq(0).click();

    cy.get(".product-detail").should("be.visible");
  });
});
