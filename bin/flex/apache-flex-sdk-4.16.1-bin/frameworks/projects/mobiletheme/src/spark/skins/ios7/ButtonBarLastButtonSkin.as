////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////

package spark.skins.ios7
{
	import spark.skins.ios7.assets.ButtonBarLastButton_up;
	
	/**
	 *  iOS7+ specific Button skin for the last Button in a ButtonBar.
	 * 
	 *  @see spark.components.ButtonBar#lastButton
	 * 
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 2.5 
	 *  @productversion Flex 4.5
	 */
	public class ButtonBarLastButtonSkin extends IOS7ButtonBarButtonSkinBase
	{
		
		/**
		 *  Constructor.
		 * 
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 2.5 
		 *  @productversion Flex 4.5
		 */
		public function ButtonBarLastButtonSkin()
		{
			super();
			
			upBorderSkin = spark.skins.ios7.assets.ButtonBarLastButton_up
			downBorderSkin = spark.skins.ios7.assets.ButtonBarLastButton_down;
			selectedBorderSkin = spark.skins.ios7.assets.ButtonBarLastButton_down;
			selectedDownBorderSkin = spark.skins.ios7.assets.ButtonBarLastButton_up;
		}
		
	}
}