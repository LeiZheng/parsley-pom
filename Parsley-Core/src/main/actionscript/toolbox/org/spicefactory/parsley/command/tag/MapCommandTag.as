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

package org.spicefactory.parsley.command.tag {

import org.spicefactory.lib.errors.IllegalStateError;
import org.spicefactory.parsley.command.MappedCommandBuilder;
import org.spicefactory.parsley.config.RootConfigurationElement;
import org.spicefactory.parsley.core.registry.ObjectDefinitionRegistry;
	
[DefaultProperty("command")]
[XmlMapping(elementName="map-command")]

/**
 * Represents a mapping in MXML or XML configuration for a managed command 
 * that gets executed when a matching message is dispatched in the Context.
 * 
 * @author Jens Halm
 */
public class MapCommandTag implements RootConfigurationElement {
	
	
	/**
	 * The command to map to the message.
	 */
	public var command:NestedCommandTag;
	
	/**
	 * The command class.
	 * If the command property is set this property will be ignored.
	 */
	public var type:Class;
	
	/**
	 * The name of the scope in which to listen for messages.
	 */ 
	public var scope:String;

	/**
	 * The type of message (including subtypes) that should trigger
	 * command execution.
	 */ 
	public var messageType:Class;

	[Attribute]
	/**
	 * The optional selector for mapping matching messages.
	 */ 
	public var selector:*;
	
	/**
	 * The execution order in relation to other message receivers.
	 * This order attribute affects all types of message receivers,
	 * not only those that execute commands.
	 */ 
	public var order:int = int.MAX_VALUE;

	/**
	 * @inheritDoc
	 */
	public function process (registry:ObjectDefinitionRegistry) : void {
		
		if (!command && !type) {
			throw new IllegalStateError("Either command or type must be specified");
		}
		
		var builder:MappedCommandBuilder = (command)
				? MappedCommandBuilder.forFactory(command.resolve(registry))
				: MappedCommandBuilder.forType(type);

		builder
			.messageType(messageType)
			.selector(selector)
			.scope(scope)
			.order(order)
			.register(registry.context);
	}
	
	
}
}
