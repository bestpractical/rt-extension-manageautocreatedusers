use inc::Module::Install;

RTx 'RT-Extension-ManageAutoCreatedUsers';
all_from 'lib/RT/Extension/ManageAutoCreatedUsers.pm';
readme_from 'lib/RT/Extension/ManageAutoCreatedUsers.pm';
license  'gplv2';

requires_rt '4.2.0';
requires 'RT::Extension::MergeUsers';
test_requires 'Test::More';

sign;
WriteAll;
