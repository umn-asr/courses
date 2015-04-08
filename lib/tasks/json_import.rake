namespace :json_import do
  desc "imports class json files from the supplied directory "
  task :directory_import, [:directory, :file_pattern] => :environment do |t, args|
    args.with_defaults(:directory => 'tmp', :file_pattern => "classes_for_*.json")
    json_files = Rake::FileList[File.join(args[:directory], args[:file_pattern])]
    json_files.each do |file|
      File.open(file) do |f|
        json = JSON.parse(f)
        JsonImport.new(json).run
      end
    end
  end
end