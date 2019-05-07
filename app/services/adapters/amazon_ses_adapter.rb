module Adapters
  class AmazonSESAdapter
    # creds automatically retrieved from
    # ENV['AWS_ACCESS_KEY_ID'] and ENV['AWS_SECRET_ACCESS_KEY']
    def self.send_mail( opts = {} )
      Rails.logger.debug "send_mail to #{opts[:to]}"
      Rails.logger.debug "raw_message: #{opts[:raw_message]}"
      Rails.logger.debug "send_mail from #{opts[:from]}"

      client.send_raw_email({
        destinations: [ opts[:to] ],
        raw_message: {
          data: opts[:raw_message].to_s
        },
        source: opts[:from]
      })
    end

    private

    # eu-west-1 is the only european region to offer SES
    # see https://aws.amazon.com/about-aws/global-infrastructure/regional-product-services/
    def self.client
      Aws::SES::Client.new(region: 'eu-west-1')
    end
  end
end
