env :MAILTO, 'asr-web-errors@lists.umn.edu'

every 1.day, :at => '2:00 am' do
  rake "json_import:directory_import[json_tmp]", output: 'log/json_import.log'
end