require "rails_helper"

RSpec.describe Admin::ToursController, type: :controller do
  let(:user) {create :user, role: :admin}
  before {sign_in user}
  let(:category) {create :category}
  let(:tour) {create :tour}
  let(:valid_attributes) do
    FactoryBot.attributes_for :tour, category_id: category.id
  end
  let(:invalid_attributes) do
    { name: "" }
  end

  it "checks admin user" do
    is_expected.to use_before_action :authenticate_admin
  end

  describe "GET index" do
    before {get :index}
    it "populates an array of tours" do
      expect(assigns(:tours)).to eq [tour]
    end

    it "renders the :index template" do
      expect(response).to render_template :index
    end
  end

  describe "GET new" do
    before {get :new}
    it "assigns a new Tour to @tour" do
      expect(assigns(:tour)).to be_a_new(Tour)
      end
    it "renders the :new template" do
      expect(response).to render_template :new
      end
  end

  describe "GET edit" do
    before do
      get :edit, params: {id: tour}
    end
    it "assigns the requested tour to @tour" do
      expect(assigns(:tour)).to eq tour
    end

    it "renders the :edit template" do
      expect(response).to render_template :edit
    end
  end

  describe "GET show" do
    before do
      get :show, params: {id: tour}
    end
    it "assigns the requested tour to @tour" do
      expect(assigns(:tour)).to eq tour
      end
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end

  describe "POST create" do
    context "with valid params" do
      it "create a new tour" do
        expect {post :create, params: {tour: valid_attributes}}.to change(Tour, :count).by(1)
      end

      it "redirects to index" do
        post :create, params: {tour: valid_attributes}
        expect(response).to redirect_to(admin_tours_path)
      end
    end

    context "with invalid params" do
      it "does not save new tour" do
        expect{post :create, params: {tour: invalid_attributes}}.to_not change(Tour, :count)
      end

      it "re-renders the new template" do
        post :create, params: {tour: invalid_attributes}
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH update" do
    context "with valid params" do
      before do
        patch :update, params: {id: tour, tour: attributes_for(:tour)}
      end
      it "locates the requested @tour" do
        expect(assigns(:tour)).to eq tour
      end

      it "changes @tour's attributes" do
        patch :update, params: {id: tour, tour: valid_attributes}
        tour.reload
        expect(tour.name).to eq valid_attributes[:name]
      end

      it "redirects to the updated tour" do
        expect(response).to redirect_to admin_tour_path(tour)
      end
    end

    context "with invalid params" do
      before do
        patch :update, params: {id: tour, tour: invalid_attributes}
      end
      it "does not change the tour's attributes" do
        tour.reload
        expect(tour.name).to_not eq invalid_attributes
      end

      it "re-renders the :edit template" do
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    context "Tour does not has booking pending" do
      before do
        delete :destroy, params: {id: tour}
      end
      it "delete the tour" do
        tour.reload
        expect(tour.deleted).to eq true
      end

      it "redirect to index" do
        expect(response).to redirect_to admin_tours_path
      end
    end

    context "Tour has booking pending"
      let(:tour_has_booking_pending) {create :tour_has_booking_pending}
      before do
        delete :destroy, params: {id: tour_has_booking_pending}
      end
      it "can not delete the tour" do
        expect(flash[:danger]).to eq I18n.t("admin.tours.destroy.error_delete")
      end

      it "redirect to index" do
        expect(response).to redirect_to admin_tours_path
      end
  end
end
