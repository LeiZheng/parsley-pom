/*
 * Copyright 2007 the original author or authors.
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
 
package org.spicefactory.lib.reflect.errors {
import org.spicefactory.lib.errors.NestedError;

/**
 * Error thrown when type conversion fails.
 * 
 * @author Jens Halm
 */
public class ConversionError extends NestedError {

	/**
	 * Create a new instance.
	 * 
	 * @param message the message associated with this error
	 * @param cause the cause of this Error
	 * @param id an optional reference number
	 */
	function ConversionError (message:String = "", cause:Error = null, id:int = 0) {
		super(message, cause, id);
	}

}

}