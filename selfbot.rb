require 'mij-discord'

module Selfbot
  # Load config before anything else
  require_relative 'config'
end

require_relative 'parser'
require_relative 'evalutils'
require_relative 'command'
require_relative 'database'

$bot = MijDiscord::Bot.new(**Selfbot::BOTOPTS)
MijDiscord::LOGGER.level = :info

$cmd = Selfbot::CommandSystem.new(Selfbot::PREFIX)
$cmd.configure($bot)

$dbc = Selfbot::Database.new(**Selfbot::DBCOPTS)

module Selfbot::Defs
  require_relative 'defs/events'
  require_relative 'defs/commands'
  require_relative 'defs/database'
end

begin
  $bot.connect(false)
rescue Interrupt
  puts("Received Ctrl-C, exiting...")
end

$bot.disconnect
$dbc.disconnect
