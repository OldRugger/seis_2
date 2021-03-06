APP_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env]
APP_CONFIG.symbolize_keys!

listener = Listen.to(APP_CONFIG[:hotfolder]) do |modified, added, removed|
  if added.length > 0
    Rails.logger.info "call TeamResults"
    TeamResults.new.perform(added)
    Rails.logger.info "added file: #{added}"
  end
  if removed.length > 0
    Rails.logger.info "removed file : #{removed}"
  end
end
listener.start
