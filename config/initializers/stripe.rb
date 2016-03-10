
Rails.configuration.stripe = {
  :publishable_key => 'pk_test_sLn1r8nxVTiSTUQvunww6GeO',
  :secret_key      => 'sk_test_O1SWklgq5WLFXgESKYE1AvGX'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
