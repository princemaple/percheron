require 'logger'

$logger = Logger.new(STDOUT)

logger_level = Logger::INFO
logger_level = Logger::WARN if ENV['QUIET'] == 'true'

if ENV['DEBUG'] == 'true' || ENV['DOCKER_DEBUG'] == 'true'
  begin
    require 'pry-byebug'
    require 'awesome_print'
  rescue LoadError
    $logger.warn 'Debugging gems are not installed'
  end

  logger_level = Logger::DEBUG

  Docker.logger = $logger if ENV['DOCKER_DEBUG'] == 'true'
end

$logger.level = logger_level