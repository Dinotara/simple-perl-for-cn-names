use Lingua::ZH::Jieba;
use utf8;

binmode STDOUT, ":utf8";

# Add Chinese surnames you need. The ones below are just examples.
my $chinese_surnames = qr/赵|钱|孙|李|周|吴|郑|王|冯|陈|褚|卫|蒋|沈|韩|杨|朱|秦|尤|许|何|吕|施|张|孔|曹|严|华|金|魏|陶|姜/;
 
# Here the text
my $text = '';

my $jieba = Lingua::ZH::Jieba->new();
my $word_tags = $jieba->tag($text);
my @name;

# The word segmentation of the Jieba library is not that accurate and may result in missed or incorrect reports.
for my $pair (@$word_tags) {
    my ($word, $part_of_speech) = @$pair;
    if (($part_of_speech eq "x") && $word !~ /[\p{P}\p{S}0-9a-zA-Z\s]/) {
        my @f = split('', $word);        
        if ($f[0] =~ /$chinese_surnames/) {
            push @name, $word unless ($word ~~ @name);
        }
    }
}

print "@name\n";

