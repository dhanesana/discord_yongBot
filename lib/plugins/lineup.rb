require 'pg'

module YongBot
  module Commands
    module Lineup
      extend Discordrb::Commands::CommandContainer

      command(:lineup, description: 'returns upcoming music show lineup (manually updated)') do |event|
        conn = PG::Connection.new(ENV['DATABASE_URL'])
        begin
          res = conn.exec_params("create table lineup (current varchar);")
          conn.exec(
            "INSERT INTO lineup (current) VALUES ('iono');"
          )
        rescue PG::Error => pg_error
          puts '*' * 50
          puts "Lineup Table creation failed: #{pg_error.message}"
        end
        conn = PG::Connection.new(ENV['DATABASE_URL'])
        lineup = conn.exec("SELECT current FROM lineup")
        event.respond "#{lineup[0]['current']}"
      end

    end
  end
end
