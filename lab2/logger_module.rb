require 'time'

module Logger
  LOG_FILE = 'app.log'

  def log(level, message)
    timestamp = Time.now.iso8601
    File.open(LOG_FILE, 'a') do |file|
      file.puts("#{timestamp} -- #{level} -- #{message}")
    end
  end

  def log_info(message)
    log('info', message)
  end

  def log_warning(message)
    log('warning', message)
  end

  def log_error(message)
    log('error', message)
  end
end
