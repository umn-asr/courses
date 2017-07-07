namespace :db do
  namespace :oracle do
    desc "Drop all tables and sequences"
    task drop_all_tables: :environment do
      fail("Don't drop all db objects in production") if Rails.env == "production"

      drop_non_tables = ActiveRecord::Base.connection_pool.with_connection do |c|
        c.select_values("select 'drop ' || object_type || ' ' || object_name || '' from user_objects where object_type in ('VIEW', 'MATERIALIZED VIEW', 'SEQUENCE', 'FUNCTION', 'SYNONYM')")
      end

      drop_non_tables.each do |command|
        ActiveRecord::Base.connection_pool.with_connection do |c|
          c.execute(command)
        end
      end

      drop_tables = ActiveRecord::Base.connection_pool.with_connection do |c|
        c.select_values("select 'drop table ' || object_name || ' cascade constraints' from user_objects where object_type in ('TABLE')")
      end

      drop_tables.each do |command|
        ActiveRecord::Base.connection_pool.with_connection do |c|
          c.execute(command)
        end
      end
    end

    desc "Rebuild all db objects"
    task rebuild: :drop_all_tables do
      Rake::Task["db:migrate"].invoke
    end
  end
end
