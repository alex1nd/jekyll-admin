import React from 'react';
import { Link } from 'react-router';
import expect from 'expect';
import { mount } from 'enzyme';
import { capitalize } from '../../utils/helpers';

import Breadcrumbs from '../Breadcrumbs';

import { content } from './fixtures';

function setup(defaultContent = content) {
  let actions = {
    onChange: expect.createSpy()
  };
  const link = `/collections/${defaultContent.collection}`;
  const type = defaultContent.collection;

  let component = mount(
    <Breadcrumbs
      link={link}
      type={type}
      path={defaultContent.path}
      {...actions}/>
  );

  return {
    component: component,
    link: component.find(Link),
    li: component.find('li'),
    input: component.find('input'),
    actions
  };
}

describe('Components::Breadcrumbs', () => {
  it('should render correctly', () => {
    const { component, link, li, input } = setup();
    expect(link.length).toBe(1);
    expect(
      link.first().prop('children')
    ).toBe(capitalize(content.collection));
    expect(input.prop('defaultValue')).toBe(content.path);
  });
  it('should call onChange', () => {
    const { input, actions } = setup();
    input.simulate('change');
    expect(actions.onChange).toHaveBeenCalled();
  });
});
