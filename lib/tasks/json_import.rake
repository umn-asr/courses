namespace :json_import do
  desc "imports class json files from the supplied directory "
  task :directory_import, [:directory, :file_pattern] => :environment do |t, args|
    args.with_defaults(:directory => 'tmp', :file_pattern => "classes_for_*.json")
    json_files = Rake::FileList[File.join(args[:directory], args[:file_pattern])]

    # ActiveRecord::Base.subclasses.each(&:delete_all)
    Campus.delete_all
    Term.delete_all
    Course.delete_all
    Subject.delete_all
    CourseAttribute.delete_all
    Section.delete_all
    InstructionMode.delete_all
    GradingBasis.delete_all
    InstructorContact.delete_all
    InstructorRole.delete_all
    Instructor.delete_all
    Day.delete_all
    Location.delete_all
    MeetingPattern.delete_all
    CombinedSection.delete_all
    Equivalency.delete_all

    {"m" => "Monday", "t" => "Tuesday", "w" => "Wednesday", "th" => "Thursday", "f" => "Friday", "sa" => "Saturday", "su" => "Sunday"}.each do |abbreviation, name|
      Day.create(abbreviation: abbreviation, name: name)
    end


    json_resources =  json_files.sort_by { |file| File.size(file) }.reverse.each_with_object([]) do |file, resources|
                        File.open(file) do |f|
                          resources << JSON.parse(f.read)
                        end
                      end

    json_resources.each do |json|
      TermJsonImport.new(json).run
      CampusJsonImport.new(json).run
    end

    number_of_parallel_processes = 3

    json_resources.each_slice(number_of_parallel_processes) do |json_set|
      json_set.each do |json|
        Process.fork do
          ActiveRecord::Base.connection_pool.with_connection do
            CourseJsonImport.new(json).run
          end
        end
      end
      Process.waitall
    end
  end
end