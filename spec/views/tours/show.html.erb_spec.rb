require "rails_helper"

RSpec.describe "tours/show.html.erb", type: :view do
  let(:user) {create :user}
  let(:tour) {create :tour}
  let(:description_details) {tour.description_details}
  let(:review) {create :review}

  before do
    assign :tour, tour
    assign :tours, [tour, tour]
    assign :description_details, description_details
    assign :reviews, [review, review]
  end

  shared_examples "display tour information" do
    it "render to banner" do
      expect(view).to render_template "share/_banner"
    end

    it "display tour's name" do
      render "share/banner"
      expect(rendered).to have_content tour.name
    end

    it "display tour's short description" do
      expect(rendered).to have_content tour.short_description
    end

    it "display tour's itinerary" do
      expect(rendered).to have_content tour.itinerary
    end

    it "display tour's content" do
      expect(rendered).to have_content tour.content
    end

    it "render description details" do
      expect(view).to render_template partial: "_detail"
    end

    it "render tours" do
      expect(view).to render_template partial: "_tour"
    end

    it "render reviews" do
      expect(view).to render_template partial: "reviews/_review"
    end
  end

  context "when is the user" do
    before do
      sign_in user
      assign :review, Review.new
      assign :rating, Rating.new
      render
    end

    it_behaves_like "display tour information"

    it "render review form" do
      expect(view).to render_template partial: "reviews/_form"
    end

    it "render rating form" do
      expect(view).to render_template partial: "ratings/_form"
    end
  end

  context "when is not the user" do
    before {render}
    it_behaves_like "display tour information"
  end
end
