//
// SecureSMTPClientSession.h
//
// $Id: //poco/1.4/NetSSL_Win/src/SecureSMTPClientSession.cpp#1 $
//
// Library: NetSSL_Win
// Package: Mail
// Module:  SecureSMTPClientSession
//
// Copyright (c) 2010, Applied Informatics Software Engineering GmbH.
// and Contributors.
//
// SPDX-License-Identifier:	BSL-1.0
//


#include "fenix/poco/NetSSL_Win/include/Poco/Net/SecureSMTPClientSession.h"
#include "fenix/poco/NetSSL_Win/include/Poco/Net/SecureStreamSocket.h"
#include "fenix/poco/NetSSL_Win/include/Poco/Net/SSLManager.h"
#include "Poco/Net/DialogSocket.h"


namespace Poco {
namespace Net {


SecureSMTPClientSession::SecureSMTPClientSession(const StreamSocket& socket):
	SMTPClientSession(socket)
{
}


SecureSMTPClientSession::SecureSMTPClientSession(const std::string& host, Poco::UInt16 port):
	SMTPClientSession(host, port),
	_host(host)
{
}


SecureSMTPClientSession::~SecureSMTPClientSession()
{
}


bool SecureSMTPClientSession::startTLS()
{
	return startTLS(SSLManager::instance().defaultClientContext());
}


bool SecureSMTPClientSession::startTLS(Context::Ptr pContext)
{
	int status = 0;
	std::string response;
	
	status = sendCommand("STARTTLS", response);
	if (!isPositiveCompletion(status)) return false;

	SecureStreamSocket sss(SecureStreamSocket::attach(socket(), _host, pContext));
	socket() = sss;
	
	return true;
}


} } // namespace Poco::Net
