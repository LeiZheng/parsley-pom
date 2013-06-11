/*
 * Copyright 2010 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 
package org.spicefactory.parsley.core.binding.impl {

import flash.events.EventDispatcher;
import flash.events.TimerEvent;
import flash.net.SharedObject;
import flash.utils.Timer;
import org.spicefactory.parsley.core.binding.PersistenceManager;
import org.spicefactory.parsley.core.scope.ScopeAware;
import org.spicefactory.parsley.core.scope.Scope;


/**
 * Default implementation of the PersistenceManager interface that persists to a local SharedObject.
 * 
 * @author Jens Halm
 */
public class LocalPersistenceManager extends EventDispatcher implements PersistenceManager, ScopeAware {
	
	private var timer:Timer;
	private var lso:SharedObject;
	
	private var scopeUuid:String;
	
	function LocalPersistenceManager (name:String = "parsley_persistence") {
		lso = SharedObject.getLocal(name);
	}
	
	/**
	 * @inheritDoc
	 */
	public function init (scope: Scope): void {
		this.scopeUuid = scope.uuid;
	}
	
	/**
	 * @inheritDoc
	 */
	public function saveValue (key:Object, value:Object) : void {
		var uuid:String = getUuid(key);
		if (lso.data[uuid] !== value) {
			lso.data[uuid] = value;
			checkTimer();
		}
	}
	
	/**
	 * @inheritDoc
	 */
	public function deleteValue (key:Object) : void {
		delete lso.data[getUuid(key)];		
		checkTimer();
	}
	
	/**
	 * @inheritDoc
	 */
	public function getValue (key:Object) : Object {
		var uuid:String = getUuid(key);
		return lso.data[uuid];
	}
	
	private function getUuid (key:Object) : String {
		return scopeUuid + "_" + key;
 	}
	
	private function checkTimer () : void {
		if (!timer) {
			timer = new Timer(1, 1);
			timer.addEventListener(TimerEvent.TIMER, flush);
			timer.start();
		}
	}
	
	private function flush (event:TimerEvent = null) : void {
		timer = null;
		lso.flush();
	}
	
}
}
