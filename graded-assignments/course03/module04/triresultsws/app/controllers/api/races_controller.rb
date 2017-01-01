module Api
  class RacesController < ApplicationController
    protect_from_forgery with: :null_session
    
    rescue_from Mongoid::Errors::DocumentNotFound do |exception|
      render plain: "woops: cannot find race[#{params[:id]}]", status: :not_found
    end

    def index
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races, offset=[#{params[:offset]}], limit=[#{params[:limit]}]"
      else
        #real implementation ...
      end
    end

    def show
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races/#{params[:id]}"
      else
        #real implementation ...
        render json: race
      end
    end

    def create
      if !request.accept || request.accept == "*/*"
        render plain: "#{params[:race][:name]}", status: :ok
      else
        #real implementation
        race = Race.create(race_params)
        render plain: race.name, status: :created 
      end
    end

    def update
      Rails.logger.debug("method=#{request.method}")
      race.update(race_params)
      render json: race
    end

    def destroy
      race.destroy
      render :nothing=>true, :status => :no_content
    end

    private
      def race_params
        params.require(:race).permit(:name, :date)
      end

      def race
        Race.find(params.require(:id))
      end
  end
end