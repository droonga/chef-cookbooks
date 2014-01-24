name             'droonga'
maintainer       'Kouhei Sutou'
maintainer_email 'kou@clear-code.com'
license          'Apache 2.0'
description      'Installs/Configures droonga'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe "droonga", "Installs and configures Droonga engine and protocol adapter"

depends "runit"
depends "build-essential"
depends "groonga"
