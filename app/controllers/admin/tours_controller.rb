module Admin
  class ToursController < BaseController
    before_action :load_tour, except: %i(index new create)
    before_action :load_categories, except: %i(index show destroy)

    def index
      @tours = Tour.newest_tour.available.paginate page: params[:page], per_page: Settings.tour.per_page
    end

    def show
      @description_details = @tour.description_details.available.hidden_expired_detail
    end

    def new
      @tour = Tour.new
    end

    def create
      @tour = Tour.new tour_params
      if @tour.save
        flash[:success] = t ".creat_success"
        redirect_to admin_tours_url
      else
        render :new
      end
    end

    def edit; end

    def update
      if @tour.update_attributes tour_params
        flash[:success] = t ".tour_updated"
        redirect_to admin_tour_url @tour
      else
        render :edit
      end
    end

    def destroy
      if @tour.has_pending_booking? @tour.id
        flash[:danger] = t ".error_delete"
      else
        @tour.delete_details
        @tour.toggle! :deleted
        flash[:success] = t ".delete_success"
      end
      redirect_to admin_tours_url
    end

    private

    def tour_params
      params.require(:tour).permit :name, :itinerary, :content, :short_description, :category_id, :image
    end

    def load_tour
      @tour = Tour.available.find_by id: params[:id]
      return if @tour
      flash[:danger] = t ".error_id_tour"
      redirect_to admin_tours_url
    end

    def load_categories
      @categories = Category.all
    end
  end
end
