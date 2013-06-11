/*
 * Copyright 2011 the original author or authors.
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

package org.spicefactory.lib.command.light {

import org.spicefactory.lib.command.adapter.CommandAdapter;
import org.spicefactory.lib.command.adapter.CommandAdapterFactory;
import org.spicefactory.lib.command.adapter.CommandAdapters;
import org.spicefactory.lib.errors.IllegalStateError;
import org.spicefactory.lib.reflect.ClassInfo;
import org.spicefactory.lib.reflect.Method;
import org.spicefactory.lib.reflect.Parameter;
import org.spicefactory.lib.reflect.Property;
import org.spicefactory.lib.reflect.types.Void;

import flash.system.ApplicationDomain;

/**
 * A CommandAdapterFactory implementation that creates adapters from
 * commands that adhere to the conventions of Spicelib's "Light Commands".
 * 
 * @author Jens Halm
 */
public class LightCommandAdapterFactory implements CommandAdapterFactory {


	private static var registered: Boolean;

	/**
	 * Registers this adapter, making Light Commands available for all command
	 * builder types. Calling this method more than once has no effect.
	 */
	public static function register (): void {
		if (!registered) {
			registered = true;
			CommandAdapters.addFactory(new LightCommandAdapterFactory());
		}
	}


	/**
	 * @inheritDoc
	 */
	public function createAdapter (instance:Object, domain:ApplicationDomain = null) : CommandAdapter {
		var info:ClassInfo = ClassInfo.forInstance(instance, domain);
		var execute:Method = info.getMethod("execute");
		if (!execute) return null;
		var async:Boolean;
		for each (var param:Parameter in execute.parameters) {
			if (param.type.getClass() == Function) {
				async = true;
				break;
			}
		}
		var callback:Property = info.getProperty("callback");
		if (callback && callback.type.getClass() != Function) {
			callback = null;
		}
		if (callback) async = true;
		var cancel:Method = info.getMethod("cancel");
		if (cancel && cancel.parameters.length > 0) {
			cancel = null;
		}
		var result:Method = info.getMethod("result");
		if (result && result.parameters.length != 1) {
			result = null;
		}
		var error:Method = info.getMethod("error");
		if (error && error.parameters.length != 1) {
			error = null;
		}
		if (async) {
			if (execute.returnType.getClass() != Void) {
				throw new IllegalStateError("Asynchronous light commands with a callback parameter"
				 + " must have a void return type");
			}
		}
		return new LightCommandAdapter(instance, execute, callback, cancel, result, error, async);
	}
	
	
}
}
