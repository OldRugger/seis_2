APP_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env]
APP_CONFIG.symbolize_keys!