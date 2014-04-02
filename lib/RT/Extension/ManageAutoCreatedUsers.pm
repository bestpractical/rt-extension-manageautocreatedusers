package RT::Extension::ManageAutoCreatedUsers;

use strict;
use warnings;

our $VERSION = '0.01';

sub get_autocreated_users {
    my $class = shift;
    my $users = RT::Users->new(RT->SystemUser);
    $users->Limit(
        FIELD => 'Comments',
        OPERATOR => 'STARTSWITH',
        VALUE => 'Autocreated',
    );
    return $users;
}

sub get_watching_tickets_for {
    my ( $class, $email_address ) = @_;
    my $tickets = RT::Tickets->new(RT->SystemUser);
    $tickets->LimitWatcher(
        OPERATOR => '=',
        VALUE => $email_address,
    );
    return $tickets;
}

=head1 NAME

RT-Extension-ManageAutoCreatedUsers - Manage auto-created users

=head1 DESCRIPTION

This extension provides a tool to easy the management of auto-created users.

For each auto-created user, the tool shows tickets that they are a watcher of,
and offer the choice of:

=over

=item No action

=item Shred, replacing with an alternate user

=item Shred entirely

=item Merge with an alternate user

=item Mark as valid

=back

The tool attempts to supply a suggested user to merge into based on a simple
heuristic which assumes the correct email address from the C<RTxMailDomainRegex>
config option. If any of the options are selected, the user will not appear
in the listing again.

=head1 RT VERSION

Works with RT 4.2

=head1 INSTALLATION

=over

=item C<perl Makefile.PL>

=item C<make>

=item C<make install>

May need root permissions

=item Edit your F</opt/rt4/etc/RT_SiteConfig.pm>

If you are using RT 4.2 or greater, add this line:

    Plugin('RT::Extension::ManageAutoCreatedUsers');

For RT 3.8 and 4.0, add this line:

    Set(@Plugins, qw(RT::Extension::ManageAutoCreatedUsers));

or add C<RT::Extension::ManageAutoCreatedUsers> to your existing C<@Plugins> line.

=item Clear your mason cache

    rm -rf /opt/rt4/var/mason_data/obj

=item Restart your webserver

=back

=head1 AUTHOR

Wallace Reis <wreis@cpan.org>

=head1 BUGS

All bugs should be reported via email to
L<bug-RT-Extension-ManageAutoCreatedUsers@rt.cpan.org|mailto:bug-RT-Extension-ManageAutoCreatedUsers@rt.cpan.org>
or via the web at
L<rt.cpan.org|http://rt.cpan.org/Public/Dist/Display.html?Name=RT-Extension-ManageAutoCreatedUsers>.

=head1 LICENSE AND COPYRIGHT

Copyright Best Practical Solutions, LLC.

This is free software, licensed under:

  The GNU General Public License, Version 2, June 1991

=cut

1;
