#region license
# Copyright (c) 2006, Georges Benatti Jr
# All rights reserved.
# Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
# Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. 
# Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution. 
# Neither the name of Georges Benatti Jr nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission. 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#endregion

namespace Boobs.Engine

import System
import System.IO

class Task:
"""Description of Task"""

	[property(Executed)]
	_executed = false

	[getter(Name)]
	_name as string
	
	[property(Description)]
	_description = ""
	
	[property(Dependencies)]
	_dependencies = []
	
	[property(Block)]
	_block as TaskBlock
	
	def constructor([required] name as string):
		_name = name
		
	def Merge([required(task.Name == _name)] task as Task):
		if task.Block and _block:
			raise BlockAlreadySetException("More than one code block assigned to '${_name}' task")
		
		_block = task.Block if task.Block
		_dependencies.ExtendUnique(task.Dependencies)
		
	def IsUpToDate(target as string, source as string):
		return true unless File.Exists(source)
		return false unless File.Exists(target)

		targetInfo = FileInfo(target)
		sourceInfo = FileInfo(source)
		
		return targetInfo.LastAccessTimeUtc >= sourceInfo.LastAccessTimeUtc
		
	virtual def ShouldRun() as bool:
		return true

	def LogDebug(msg as string):
		print "Debug ${Name}: ${msg}"
	
	def LogWarn(msg as string):
		print "Warn ${Name}: ${msg}"
		
	def LogError(msg as string):
		print "Error ${Name}: ${msg}"
