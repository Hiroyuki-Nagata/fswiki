###############################################################################
#
# ������ɥ���å���������ޤ���
#
###############################################################################
package plugin::admin::DeleteCache;
use strict;

#==============================================================================
# ���󥹥ȥ饯��
#==============================================================================
sub new {
	return bless {}, shift;
}

#==============================================================================
# �եå�
#==============================================================================
sub hook {
	my (undef, $wiki) = @_;
	my $log_dir = $wiki->config('log_dir');
	my @cachefiles = ('keywords2.cache', 'keywords.cache');

	# ����å���ե����뤬����к����
	foreach my $cache (@cachefiles) {
		my $cachefile = $log_dir . '/' . $cache;
		unlink $cachefile if (-e $cachefile);
	}
}

1;