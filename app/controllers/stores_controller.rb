class StoresController < ApplicationController
    def index
        @stores = Store.all
    end

    def show
        @store = Store.find(params[:id])
    end

    def edit
        @store = Store.find(params[:id])
    end

    def update
        @store = Store.find(params[:id])
        if @store.update(store_params)
            redirect_to @store
        else
            render 'edit'
        end
    end

    def new
        @store = Store.new
    end

    def create
        @store = Store.new(store_params)
        if @store.save
            redirect_to dashboard_index_path
        else
            render :new
        end
    end

    def store_params
        params.require(:store).permit(:name, :address)
    end
end
