API_PATH = "/api/rest/v1"
API = OAuth::Consumer.new("plukevdh", "mRaBner3T5MX3rDUQPzhvjHv8XgHSb6D", {
                         site: "https://www.readability.com",
                         authorize_path: "#{API_PATH}/oauth/authorize/",
                         access_token_path: "#{API_PATH}/oauth/access_token/",
                         request_token_path: "#{API_PATH}/oauth/request_token/"})
