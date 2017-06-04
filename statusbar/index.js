const i3bar = require('@statusbar/i3bar')
const date = require('@statusbar/date')
// const brightness = require('@statusbar/brightness')
const battery = require('@statusbar/battery')
const diskusage = require('@statusbar/diskusage')
const volume = require('@statusbar/volume')
const text = require('@statusbar/text')
const wifi = require('@statusbar/wifi')
const nowPlaying = require('@statusbar/mpd')

bar.use(diskusage('/dev/sda3'))
bar.use(diskusage({ fs: '/dev/sdb2', label: 'Storage' }))
bar.use(wifi())
// bar.use(brightness())
bar.use(battery())
bar.use(volume())
bar.use(nowPlaying({
  format: '» {artist} – {title} {elapsed}/{duration}'
}))
bar.use(date())

bar.use(i3bar())
