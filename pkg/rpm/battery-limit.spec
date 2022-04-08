#INCOMPLETE
Summary: a simple script to limit battery charge
Name: battery-limit
Version: 0.1
Release: 1%{?dist}
License: GPL
URL: https://gitlab.com/elagost/battery-limit
Source: https://github.com/elagost/battery-limit/archive/%{version}.tar.gz

BuildRequires: systemd

Requires: systemd

#%global debug_package %{nil}

%description
Limit the battery charge of a battery-powered Linux device with systemd.

%prep
%setup -q

%install
cp battery-limit.sh %{_bindir}/battery-limit.sh

%files
%{_bindir}/battery-limit.sh
%doc README.md
%license LICENSE

%changelog
* Fri Apr 5 2022 Adam Thiede <me@adamthiede.com>
- Created spec file
