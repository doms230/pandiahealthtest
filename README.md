# Pandia Health 
## Test project to test out Stripe Hosted Check Out with Ruby and Sinatra

[Live Test](https://pandiahealth.herokuapp.com)

To test locally: 
1. cd STRIPEBILLING 
2. ruby server.rb

## Testing 
| Number | Description | 
| ----------- | ----------- |
| 4242 4242 4242 4242 | Succeeds and immediately processes the payment. |
| 4000 0000 0000 3220 | 3D Secure 2 authentication must be completed for a successful payment. |
| 4000 0000 0000 9995 | Always fails with a decline code of insufficient_funds. |

- Any CVC can be used
- Any EXP date in the future
- Any Zipcode 

- Apple and Google Pay is available with Stripe Checkout, but further setup is required through Stripe settings



