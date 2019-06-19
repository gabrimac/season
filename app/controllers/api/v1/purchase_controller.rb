module Api
  module V1
    # the method pay_purchase simplify buying the multimedia content with an external tpv like
    # paypal and alwas return true
    class PurchaseController < ApplicationController
      def create
        purchase = Purchase.create(
          purchase_option_id: purchase_params[:purchase_option_id],
          user: current_user
        )

        if pay_purchase(purchase)
          current_user.library

          LibraryContent.create(
            library: current_user.library,
            content: purchase.purchase_option.content,
            expires_at: Date.today + 2.day,
            quality: purchase.purchase_option.quality
          )

          render jsonapi: purchase
        else
          render json: {
            errors: {
              id: 'purchase cancelled',
              detail: 'The purchase has been cancelled by the external platform'
            }
          }
        end
      end

      private

      def pay_purchase(purchase)
        true
      end

      def purchase_params
        params.require(:purchase).permit(:purchase_option_id)
      end

    end
  end
end
