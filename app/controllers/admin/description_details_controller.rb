module Admin
  class DescriptionDetailsController < BaseController
    before_action :load_description_detail, only: %i(edit update destroy)
    before_action :load_tour, only: %i(new create)

    def new
      @description_detail = DescriptionDetail.new
    end

    def create
      @description_detail = @tour.description_details.build description_detail_params
      if @description_detail.save
        flash[:success] = t ".create_success"
        redirect_to admin_tour_url @description_detail.tour_id
      else
        render :new
      end
    end

    def edit; end

    def update
      if @description_detail.update_attributes description_detail_params
        flash[:success] = t ".detail_updated"
        redirect_to admin_tour_url @description_detail.tour_id
      else
        render :edit
      end
    end

    def destroy
      case
      when @description_detail.pending_booking?(@description_detail.id)
        flash[:danger] = t ".error_delete"
      when @description_detail.bookings.any?
        @description_detail.toggle! :deleted
        flash[:success] = t ".delete_success"
      else
        @description_detail.destroy
        flash[:success] = t ".delete_success"
      end
      redirect_to admin_tour_url @description_detail.tour_id
    end

    private

    def description_detail_params
      params.require(:description_detail).permit :price, :tour_id, :start_day, :end_day
    end

    def load_description_detail
      @description_detail = DescriptionDetail.available.hidden_expired_detail.find_by id: params[:id]
      return if @description_detail
      flash[:danger] = t ".error_detail_id"
      redirect_to admin_tours_url
    end

    def load_tour
      @tour = Tour.available.hidden_expired_detail.find_by id: params[:tour_id]
      return if @tour
      flash[:danger] = t ".error_tour_id"
      redirect_to admin_tours_url
    end
  end
end
