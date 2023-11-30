env :MAILTO, "asr-web-errors@lists.umn.edu"

every 1.day, at: "2:00 am" do
  rake "json_import:update_all['tmp/json_tmp']", output: {standard: nil}
end
