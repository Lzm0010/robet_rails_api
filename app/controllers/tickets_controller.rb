class TicketsController < ApplicationController
    def create
        ticket = Ticket.new(ticket_params)
        if ticket.save
          render json: ticket
        else
          render json: {"message": "Something went wrong. Ticket was not saved."}
        end
    end

    def show
        ticket = Ticket.find(params[:id])
        render json: ticket
    end
    
    def update
        ticket = Ticket.find(params[:id])
        if ticket.update_attributes(ticket_params)
          render json: ticket
        else
          render json: {"message": "Something went wrong. Update was not saved."}
        end
    end

    def destroy
        ticket = Ticket.find(params[:id])
        if ticket.destroy
            render json: ticket
        else
            render json: {"message": "Something went wrong. Your Ticket was not deleted."}
        end
    end
    
    private
    
    def ticket_params
        params.require(:ticket).permit(:user_id, :bet_id, :amount)
    end
end
