################################################################################
#
# <p>現在表示しているページの文字数を表示するインラインプラグインです。</p>
# <pre>
# 文字数：{{wordcount}}
# </pre>
# <p>引数でカウント対象のページを指定することもできます。</p>
# <pre>
# 文字数：{{wordcount ページ名}}
# </pre>
#
################################################################################
package plugin::book::Wordcount;
use strict;
use warnings;
use Encode qw(decode);
#==============================================================================
# コンストラクタ
#==============================================================================
sub new {
	my $class = shift;
	my $self = {};
	return bless $self,$class;
}

#==============================================================================
# インラインメソッド
#==============================================================================
sub inline {
	my $self = shift;
	my $wiki = shift;
	my $page = shift;
	
	$page = $wiki->get_CGI->param('page') unless $page;
	my $source = Jcode::convert($wiki->get_page($page), 'utf8', 'euc');
	
	return length(decode('utf-8', $source));
}

1;
