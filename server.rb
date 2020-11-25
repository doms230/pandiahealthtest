require 'stripe'
#require 'dotenv'
require 'sinatra'  
#TODO
#Dotenv.load
#API reference for Stripe Checkout Sessions: https://stripe.com/docs/api/checkout/sessions/create?lang=ruby
Stripe.api_key = 'sk_test_51Hr7x2GU7qXZje79CcVjiiXBGSZlbEE6tYibP4xkYOGripUXcD1QIk9FiGELBFMcSpmNADEz3SF5hDIMEXuBZ9EW00LhJOuEcz'

set :static, true 
set :public_folder, "./client"
set :port, 3000

#YOUR_DOMAIN = 'http://localhost:3000'
YOUR_DOMAIN = 'https://pandiahealth.herokuapp.com/'

get '/' do 
 content_type 'text/html'
 send_file File.join(settings.public_folder, 'index.html');
end 

get '/stripe-key' do 
    content_type "application/json" 
    {  key: "pk_test_51Hr7x2GU7qXZje79IRpvlwPgCOz1kciV9leDYpR6FCaFbmFcxQ9zQSI8hqLbrRyn03AVNn6ShqgiyDsMb2AV0Z0J00c4hmidYn"
    }.to_json
end 

post '/create-session' do 
    content_type 'application/json'
    session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        #customer would be loaded beforehand and provided from database for redirect. 
        #If new customer, Stripe will automatically create a new one.
        #The new customer id should be attached to the customer in the database.
        customer: "cus_ISN16v1sAwSsVH",
        #customer_email: prefill customer's email if already saved on file
        #metadata: If there is other things used to keep track of customer like database id, etc.
        line_items: [{
          price_data: {
            unit_amount: 2000,
            currency: 'usd',
            product_data: {
              name: 'Birth Control',
              images: ['https://www.pandiahealth.com/wp-content/uploads/2020/04/hero-1-B-1.png'],
            },
          },
          #price: {{PRICE_ID}} If returning customer, prefill their payment details so they don't have to fill in again. 
          #When customer uses new card, that card is attached to the customer and a price id is assigned. 
          #That price id can be used to make payments
          quantity: 1,
        }],
        mode: 'payment',
        #in a live version, the success and cancel urls would probably take the customer elsewhere.
        success_url: YOUR_DOMAIN,
        cancel_url: YOUR_DOMAIN,
      }) 
      {
        id: session.id
      }.to_json
    
    end
