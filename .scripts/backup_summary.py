#!/run/current-system/sw/bin/python
def humanize_bytes(bytesize, precision=0):
    abbrevs = (
        (1 << 50, 'PB'),
        (1 << 40, 'TB'),
        (1 << 30, 'GB'),
        (1 << 20, 'MB'),
        (1 << 10, 'kB'),
        (1, 'bytes')
    )
    if bytesize == 1:
        return '1 byte'
    for factor, suffix in abbrevs:
        if bytesize >= factor:
            break
    return '%.*f%s' % (precision, bytesize / factor, suffix)


def secToTime(s):
    m, s = divmod(s, 60)
    if m <= 0:
        return '{0:.0f}s'.format(s)

    return '{0:.0f}m {1:.0f}s'.format(m, s)


import sys
import json

srv = ' '.join(sys.argv[1:])
try:
    output = sys.stdin.read()

    j = json.loads(output)
    s = humanize_bytes(j['archive']['stats']['deduplicated_size'])
    t = secToTime(j['archive']['duration'])
    print('  {} ({}, +{})'.format(srv, t, s))
except Exception:
    print('  {}'.format(srv))
