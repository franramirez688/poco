//
// SecureSMTPClientSession.h
//
// $Id: //poco/1.4/NetSSL_OpenSSL/src/SecureSMTPClientSession.cpp#2 $
//
// Library: NetSSL_OpenSSL
// Package: Mail
// Module:  SecureSMTPClientSession
//
// Copyright (c) 2010, Applied Informatics Software Engineering GmbH.
// and Contributors.
//
// Permission is hereby granted, free of charge, to any person or organization
// obtaining a copy of the software and accompanying documentation covered by
// this license (the "Software") to use, reproduce, display, distribute,
// execute, and transmit the Software, and to prepare derivative works of the
// Software, and to permit third-parties to whom the Software is furnished to
// do so, all subject to the following:
// 
// The copyright notices in the Software and this entire statement, including
// the above license grant, this restriction and the following disclaimer,
// must be included in all copies of the Software, in whole or in part, and
// all derivative works of the Software, unless such copies or derivative
// works are solely in the form of machine-executable object code generated by
// a source language processor.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
// SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
// FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.
//


#include "fenix/poco/NetSSL_OpenSSL/include/Poco/Net/SecureSMTPClientSession.h"
#include "fenix/poco/NetSSL_OpenSSL/include/Poco/Net/SecureStreamSocket.h"
#include "fenix/poco/NetSSL_OpenSSL/include/Poco/Net/SSLManager.h"
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
