  namespace :gold do

    task :export do
      require RAILS_ROOT + '/config/environment'
      conn = ActiveRecord::Base.connection
      tables = conn.tables.reject {|i| i == 'schema_info'}
      tables.each do |table|
        filename = RAILS_ROOT + '/gold/data/' + table.pluralize + '.yml'
        open(filename, 'w') do |f|
          rows = conn.select_all("SELECT * FROM #{table}")
          rows.each do |row|
            f.puts("gold_#{row["id"]}:")
            row.keys.each do |key|
              f.puts "  #{key}: #{row[key]}"
            end
          end
        end
      end

    end

    task :import do
      require RAILS_ROOT + '/config/environment'
      require 'test_help'
      Dir.glob(RAILS_ROOT + '/gold/data/*.yml').each do |file|
        Fixtures.create_fixtures(
          RAILS_ROOT + '/gold/data',
          File.basename(file, '.yml'))
      end
    end

  end