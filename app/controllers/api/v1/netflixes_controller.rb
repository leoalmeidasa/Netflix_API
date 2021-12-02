# frozen_string_literal: true

module Api
  module V1
    class NetflixesController < ApplicationController
      before_action :set_netflix, only: %i[show update destroy]

      # GET /netflixes
      def index
        @netflixes = if params['country'].present?
                       Netflix.country(params['country'])
                     elsif params['genre'].present?
                       Netflix.genre(params['genre'])
                     elsif params['published_at'].present?
                       Netflix.published_at(params['published_at'])
                     else
                       Netflix.all.order('published_at ASC')
                     end

        render json: @netflixes
      end

      # POST /netflixes
      def create
        @netflix = Netflix.new(netflix_params)

        if @netflix.save
          render json: @netflix, status: :created
        else
          render json: @netflix.errors, status: :unprocessable_entity
        end
      end

      # GET /netflixes/1
      def show; end

      # PATCH/PUT /netflixes/1
      def update
        if @netflix.update(netflix_params)
          render json: 'Update Completed Successful', status: :ok
        else
          render json: @netflix.errors, status: :unprocessable_entity
        end
      end

      # DELETE /netflixes/1
      def destroy
        if @netflix.destroy
          render json: {
            message: 'Deleted'
          }, status: :ok
        else
          render json: @netflix.errors, status: :unprocessable_entity
        end
      end

      def upload
        NetflixService.new.import(params[:file].path)
        redirect_to api_v1_netflixes_url, notice: 'Upload Completed Successful'
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_netflix
        @netflix = Netflix.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def netflix_params
        params.require(:netflix).permit(:id_csv, :genre, :title, :director, :cast, :country,
                                        :published_at, :year, :rating, :duration, :listed_in, :description)
      end
    end
  end
end
