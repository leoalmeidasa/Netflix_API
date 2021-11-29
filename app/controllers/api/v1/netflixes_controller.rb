module Api
  module V1
    class NetflixesController < ApplicationController
      before_action :set_netflix, only: [:show, :update, :destroy]

      # GET /netflixes
      def index
        render json: @netflixes = Netflix.all.order("published_at ASC")
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
          render json: "Update Completed Successful", status: :ok
        else
          render json: @netflix.errors, status: :unprocessable_entity
        end
      end

      # DELETE /netflixes/1
      def destroy
        if @netflix.destroy
          render json: {
            message: "Deleted"
          }, status: :ok
        else
          render json: @netflix.errors, status: :unprocessable_entity
        end
      end

      def upload
        Netflix.import(params[:file])
        render json: "Upload Completed Successful", status: :created
      end

      # GET /netflixes/country
      def country
        @netflixes = Netflix.country('Brazil')
        render json: @netflixes
      end

      # GET /netflixes/genre
      def genre
        @netflixes = Netflix.genre('TV Show')
        render json: @netflixes
      end

      # GET /netflixes/published
      def published
        @netflixes = Netflix.published_at('2021-01-01')
        render json: @netflixes
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
