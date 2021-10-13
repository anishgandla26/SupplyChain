import React from 'react';
import {Menu} from 'semantic-ui-react';
import {Link} from '../routes';

export default () => {
	return (
		<Menu style = {{ marginTop: '10px' }}>
			<Link route="/">
				<a className="item">Supply Chain</a>
			</Link>
        	<Menu.Menu position='right'>
          		<Link route="/supply-chain/new">
					<a className="item">Create Supply Chain</a>
				</Link>
				<Link route="/supply-chain/new">
					<a className="item">+</a>
				</Link>
        	</Menu.Menu>
      	</Menu>
	);
};